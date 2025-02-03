const Alert = ({ message, type }) => {
  return (
    <div className="toast toast-top toast-end top-15 right-15 z-2">
      <div className={`alert alert-${type}`}>
        <span>{message}</span>
      </div>
    </div>
  );
};

export default Alert;
